# uri-packs

Monorepo z osobnymi paczkami URI capability dla ekosystemu TellMesh.

```text
URI → manifest → policy → handler → event → result
```

Paczki są ładowane przez [`urisys`](../urisys) — ten projekt dostarcza tylko manifesty i handlery, bez runtime/controllera.

## Skład

```text
../uricore/      # osobne repo: parser, registry, dispatcher, event store, policy
../uricore-js/   # osobne repo: JS/browser/Node runtime
../urisys/       # osobne repo: kontrolery, managery, HTTP server, flow, Markpact
packages/python  # paczki: uribrowser, uridocker, urisystemd...
packages/js      # paczki JS: uridom-js, uripage-js, urinode-js...
scripts/         # instalacja i smoke test całego stacku
examples/        # przykłady integracyjne (node-server)
```

## Python URI packs

- `uribrowser` → `browser://`
- `uridesktop` → `desktop://`
- `uriandroid` → `android://`
- `uridocker` → `docker://`
- `urisystemd` → `systemd://`
- `uriprinter` → `printer://`
- `uricamera` → `camera://`
- `uridisplay` → `display://`
- `urimail` → `mail://`
- `urillm` → `llm://`
- `uriagent` → `agent://`

## JavaScript URI packs

- `uridom-js` → `dom://`
- `uripage-js` → `page://`
- `urinode-js` → `node://`
- `uribrowser-js` → browser-side umbrella package

## Instalacja lokalna

Wymaga sklonowanych sąsiadujących repozytoriów: `uricore`, `urisys`.

```bash
python -m venv .venv
. .venv/bin/activate
./scripts/install-editable.sh
```

## Przykłady

```bash
urisys --packs browser call browser://default/page/open \
  --payload '{"url":"https://example.com"}' \
  --approve
```

```bash
urisys --packs docker call docker://container/web/command/restart \
  --approve \
  --dry-run
```

```bash
./scripts/smoke-test.sh
```

Dokumentacja runtime i Markpact: [`../urisys/README.md`](../urisys/README.md)


## License

Licensed under Apache-2.0.
