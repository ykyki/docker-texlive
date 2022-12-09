# docker-texlive

## Packages

- TeX Live 2020 (⚠️ 3.8GB over!): <https://github.com/ykyki/docker-texlive/pkgs/container/docker-texlive-2020>

## Usage

```sh
# Example

# Pull image
docker pull ghcr.io/ykyki/docker-texlive-2020:1.3

# Run latexmk
docker run --rm -v $(pwd):/workdir ghcr.io/ykyki/docker-texlive-2020:1.1 latexmk ./target-file-name.tex
```

## References

- <https://github.com/doraTeX/Docker-TeXLive-haranoaji>

