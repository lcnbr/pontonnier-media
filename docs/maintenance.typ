= Maintaining website media

This repository stores media for #link("https://github.com/lcnbr/pontonnier").
Preserve the `assets/` directory structure: the website’s Typst sources refer to
these paths, and changing them requires a corresponding source update.

== Publishing a media change

+ Add or update the files here, then commit and push to `main`.
+ In the Typst source repository, update `assets/manifest.json` for affected
  files. Record their path, source URL, byte size and SHA-256 checksum. Images
  also carry their intrinsic width and height in pixels.
+ Set `.media-revision` in the Typst repository to the full commit SHA from this
  repository. A commit there triggers CI and publishes the combined website.

The explicit revision keeps source changes reproducible. Pushing media alone
does not change the live site until the source repository selects that revision.
The build reads this public repository without personal access tokens.

== Provenance

Media retains its original authorship and rights. No blanket license is granted
by this repository. The source repository’s `docs/sources.typ` and
`assets/manifest.json` record attribution and the original download URLs.

The initial media snapshot contains the exact 1,021 files from source commit
`828363b5284f673d02ffb8a3275d4985d1f05508`. The tag
`source-before-media-split-2026-10-17` preserves that complete source history,
including all previous content edits. It is a recovery reference, not the
media revision used by the website.

== Originals and mosaic images

`originals/` contains the best-resolution files recovered from the public source.
Their names are their SHA-256 checksum; bytes and EXIF data are not altered.
`originals/manifest.json` maps each logical site image to the selected source,
dimensions and checksum. Existing full-size files already in `assets/` are reused.

`assets/thumbnails/` contains static, uncropped WebP renditions for mosaics and
album covers. Each is at most 960 pixels on its longest side and 128 KiB.
The source repository's `scripts/upgrade-media.mjs` maintains both sets; run it
with this repository as its media-checkout argument and commit its source
manifest update together with the new `.media-revision` in the Typst repository.
It caches public downloads under the system temporary directory so interrupted
runs can resume. The temporary download cache may be removed before a later
refresh to recheck changed source URLs.

Originals are served on demand from a version-pinned GitHub Raw URL when a
visitor opens the fullscreen viewer. They are deliberately outside `assets/`,
so the website's partial media checkout and Pages bundle exclude them. This
keeps Pages below its 1 GB published-site limit and does not enlarge Typst Sync.
