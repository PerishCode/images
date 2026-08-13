# Agents

This repository is the public OCI source closure for Perish images. It authors
image content and the cold-start workflows that prove and publish that content;
it never owns runner activation, appliance deployment, or a custom executable.

## Shape

- `Containerfile.<name>` defines one image.
- `docker-bake.hcl` is the complete build graph and image naming contract.
- `.forgejo/workflows` contains only native cold-start guard and publication.
- Do not add a CLI, task runner, generated build context, reusable action, or
  runner control logic.

## Closure

- Every base image is a public OCI reference pinned by digest.
- Images contain no private CA, credential, appliance route, or dependency
  mirror configuration.
- `mirror.perish.lan` is never an input or publication authority.
- Deno compatibility and Forgejo Runner lifecycle are outside this repository.
- Release identity is an immutable image digest with anonymous public readback.

## Workflow

- Cold-start jobs target the `bootstrap` label on a disposable host runner with
  Git, Docker, and Buildx. Actions owns that runner's registration and lifetime.
- Guard execution is credential-free and only consumes public upstream images.
- Publication is manual, receives a registry-neutral OCI prefix and credentials,
  logs out after pushing, and then proves anonymous readback.
- Do not execute untrusted pull-request image builds against a host Docker socket.

## Operating

- Never commit on `main`; work on a branch and land through the repository guard.
- Run `plumb doctor .`, `ectropy .`, `docker buildx bake --print`, and the default
  Bake group before landing.
- Keep accelerators, caches, labels, tokens, and deployment policy in Actions or
  Hardrig according to their existing ownership boundaries.
