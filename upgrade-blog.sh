#!/bin/bash
mkdocs build --clean
rm -rf $(ls site)
mv site/* ./