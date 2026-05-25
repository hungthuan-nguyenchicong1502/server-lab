make setting-help

make laravel-app-vi-composer-json

cat README.md

## laravel-app -> composer.json
```
"require": {
        "ncc/packages-ncc": "dev-main"
    },
    "repositories": [
        {
            "type": "path",
            "url": "../packages-ncc",
            "options": {
                "symlink": true
            }
        }
    ],
```