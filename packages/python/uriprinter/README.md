# uriprinter

Separate Python URI capability pack for `printer://`.

This package contains only:

- `manifest.yaml` — route/capability declaration
- `handlers.py` — implementation for the declared operations
- `common.py` — small safe/mock helper utilities

It does **not** contain a server, CLI, dashboard or hypervisor. Use `urisys` for controllers/managers:

```bash
urisys explain printer://demo/query/status --packs printer
urisys call printer://demo/query/status --packs printer
```

Real execution is the default. Use `--approve` for mutations. Use `--dry-run` or `--environment mock` to simulate.
