#! /bin/bash
xcode-select --install ; wait ;
xcodebuild -license accept 2>/dev/null || true;
exit 0
