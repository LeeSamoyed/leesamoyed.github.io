#!/bin/bash
mkdocs build --clean
cp -r site/* ./
rm -rf site