#!/bin/bash

# Smoke test for installation

echo "[Test] Checking if stow is installed..."
if ! command -v stow &> /dev/null; then
  echo "[Test] stow is not installed."
  exit 1
fi

echo "[Test] Checking if git is installed..."
if ! command -v git &> /dev/null; then
  echo "[Test] git is not installed."
  exit 1
fi

echo "[Test] All tests passed."
