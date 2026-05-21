# Handout build system for the algebra study notes.
#
#   just                    build every handout (question paper + all solutions)
#   just build PATH         build a single handout
#   just watch PATH [Q]     live-rebuild a handout's full solution (or question Q)
#   just count PATH         show how many questions a handout declares
#   just clean              remove every generated PDF
#
# Slides are intentionally left out: they need extra steps and aren't handouts.

handouts := "handouts"

# Build handouts: no PATH builds every handout under `handouts/`, a PATH builds one.
build path='':
    #!/usr/bin/env bash
    set -euo pipefail
    if [ -n '{{path}}' ]; then
      srcs=('{{path}}')
    else
      mapfile -t srcs < <(find {{handouts}} -maxdepth 1 -type f -name '*.typ' | sort)
    fi
    for src in "${srcs[@]}"; do
      just _build_one "$src"
    done

# Build every variant of one handout: question paper, full solution,
# and one PDF per question.
_build_one src:
    #!/usr/bin/env bash
    set -euo pipefail
    src='{{src}}'
    stem="${src%.typ}"
    name="$(basename "$stem")"
    soldir="$(dirname "$stem")/$name-sol"
    mkdir -p "$soldir"

    # question paper (no answers) — stays next to the source
    echo "==> $name — question paper"
    typst compile --root . --input answers=false "$src" "$stem.pdf"

    # full solution — lives in the solution directory
    echo "==> $name — full solution"
    typst compile --root . --input answers=true "$src" "$soldir/$name-sol.pdf"

    # one solution PDF per question, count discovered from the document itself
    count="$(just count "$src")"
    echo "==> $name — $count per-question solutions"
    for i in $(seq 1 "$count"); do
      typst compile --root . --input sol-q="$i" "$src" "$soldir/$name-sol-q$i.pdf"
    done

# Number of questions a handout declares (via `<question-count>` metadata).
count src:
    @typst query --root . --field value --one '{{src}}' "<question-count>"

# Live-rebuild a handout on change: the full solution, or question Q if given.
watch src q='':
    #!/usr/bin/env bash
    set -euo pipefail
    src='{{src}}'
    stem="${src%.typ}"
    name="$(basename "$stem")"
    soldir="$(dirname "$stem")/$name-sol"
    mkdir -p "$soldir"
    if [ -n '{{q}}' ]; then
      exec typst watch --root . --input sol-q='{{q}}' "$src" "$soldir/$name-sol-q{{q}}.pdf"
    else
      exec typst watch --root . --input answers=true "$src" "$soldir/$name-sol.pdf"
    fi

# Remove every generated PDF and solution directory.
clean:
    @find {{handouts}} . -maxdepth 3 -type f -name '*.pdf' -delete
