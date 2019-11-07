# Changelog

## 2.0.0

Breaking Changes

* Config format changed to support using priv directories instead of relative or absolute
paths. The value for each of the info file keys must be a map of options instead of a
string representing the path. The map must contain a `:type` and `:path` key, and
optionally, an `:application` key.

## 1.1.0

Breaking Changes

* Require Elixir 1.8 or greater

Bugfixes

* Address compiler warnings when building on Elixir 1.9 caused by dependencies

## 1.0.0

Bugfixes

* Address some compiler warnings

## 0.1.0

Highlights

* initial setup
