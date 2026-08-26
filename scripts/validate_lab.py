#!/usr/bin/env python3
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
IGNORE_DIRS = {".git", "node_modules", "build", "dist", ".gradle"}
TOKEN_PATTERNS = {
    "github_classic_pat": re.compile(r"ghp_[A-Za-z0-9]{30,}"),
    "github_fine_grained_pat": re.compile(r"github_pat_[A-Za-z0-9_]{30,}"),
    "openrouter_key": re.compile(r"sk-or-v1-[A-Za-z0-9_-]{20,}"),
    "private_key": re.compile(r"-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----"),
    "aws_access_key": re.compile(r"AKIA[0-9A-Z]{16}"),
}


def files():
    for path in ROOT.rglob("*"):
        if not path.is_file() or any(part in IGNORE_DIRS for part in path.parts):
            continue
        yield path


def main() -> int:
    errors = []
    for path in files():
        rel = path.relative_to(ROOT)
        if path.name == ".env" or path.name.startswith(".env."):
            errors.append(f"forbidden env file: {rel}")
            continue
        try:
            text = path.read_text(encoding="utf-8")
        except (UnicodeDecodeError, OSError):
            continue
        for name, pattern in TOKEN_PATTERNS.items():
            if pattern.search(text):
                errors.append(f"possible {name}: {rel}")
        if path.name == "storeamo.json":
            try:
                manifest = json.loads(text)
            except json.JSONDecodeError as exc:
                errors.append(f"invalid storeamo manifest {rel}: {exc}")
                continue
            if manifest.get("status") == "verified":
                errors.append(f"Labs cannot self-declare verified: {rel}")
    if errors:
        for error in errors:
            print("FAIL", error)
        return 1
    print("LAB_OK no obvious secrets; no self-verified StoreAMO candidates")
    return 0


if __name__ == "__main__":
    sys.exit(main())
