# uridisplay

Separate Python URI capability pack for `display://`.

This package contains only:

- `manifest.yaml` — route/capability declaration
- `handlers.py` — implementation for the declared operations
- `common.py` — small safe/mock helper utilities

It does **not** contain a server, CLI, dashboard or hypervisor. Use `urisys` for controllers/managers:

```bash
urisys explain display://demo/query/status --packs display
urisys call display://demo/query/status --packs display
```

Real execution is the default. Use `--approve` for mutations. Use `--dry-run` or `--environment mock` to simulate.
