---
name: deprecate-cpan-module
description: deprecate cpan module
---

Help the user deprecate a CPAN module.

## Overview

Deprecating a CPAN module requires two things:

1. **Add `x_deprecated: 1` to the distribution metadata**
2. **Update the documentation (POD)**

Reference: https://neilb.org/2015/01/17/deprecated-metadata.html

## Steps

### 1. Identify the build tool

Check the project root to determine which build tool is being used:

- `dist.ini` → **Dist::Zilla**
- `minil.toml` → **Minilla**
- `Makefile.PL` → **ExtUtils::MakeMaker** or **Module::Install**
- `Build.PL` → **Module::Build**

### 2. Add x_deprecated to the metadata

#### Dist::Zilla (`dist.ini`)

```ini
[Deprecated]
```

#### Minilla (`minil.toml`)

```toml
[Metadata]
x_deprecated = 1
```

#### ExtUtils::MakeMaker (`Makefile.PL`)

```perl
META_MERGE => {
    'meta-spec' => { version => 2 },
    x_deprecated => 1,
},
```

#### Module::Build (`Build.PL`)

```perl
meta_merge => {
    x_deprecated => 1,
},
```

#### Module::Install (`Makefile.PL`)

```perl
add_metadata x_deprecated => 1;
```

### 3. Update the POD documentation

#### Add "(DEPRECATED)" to the abstract in the NAME section

```pod
=head1 NAME

Some::Module - (DEPRECATED) original description
```

#### Add a deprecation notice at the top of the DESCRIPTION section

If a replacement module exists:
```pod
=head1 DESCRIPTION

B<This module is deprecated.> Use L<Other::Module> instead.
```

If no replacement exists:
```pod
=head1 DESCRIPTION

B<This module is deprecated.> Do not use it in new code.
```

### 4. Release a new version

Commit the changes and release a new version to CPAN.

## Checklist

- [ ] Added `x_deprecated` to the build tool configuration
- [ ] Added "(DEPRECATED)" to the NAME section abstract
- [ ] Added a deprecation notice (and replacement module if applicable) to DESCRIPTION
- [ ] Released a new version
