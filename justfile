build:
  @find handouts -type f -name '*.typ' -print0 | sort -z | while IFS= read -r -d '' src; do \
    out="${src%.typ}"; \
    typst compile --root . --input answers=false "$src" "${out}.pdf"; \
    typst compile --root . --input answers=true "$src" "${out}-sol.pdf"; \
  done

clean:
  @find handouts -type f -name '*.pdf' -delete
  @find . -maxdepth 1 -type f -name '*.pdf' -delete
