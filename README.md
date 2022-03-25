# httpie

httpie running in docker alpine (python3+pip3+alpine+httpie)

Auto-trigger docker build for [httpie](https://github.com/jakubroztocil/httpie) when new release is announced


[![DockerHub Badge](http://dockeri.co/image/alpine/httpie)](https://hub.docker.com/r/alpine/httpie/)


### Github Repo

https://github.com/alpine-docker/httpie

### Daily Travis CI build logs

https://travis-ci.com/alpine-docker/httpie

### Docker image tags

https://hub.docker.com/r/alpine/httpie/tags/

### Notes

This is personal project to build httpie in alpine linux.

### Usage

```bash
$ alias http='docker run -ti --rm alpine/httpie'
$ alias https='docker run -ti --rm --entrypoint=https alpine/httpie'
```

To use and persist a [`.netrc`](https://httpie.org/docs#netrc) file:

```bash
$ alias http='docker run -ti --rm -v ~/.netrc:/root/.netrc alpine/httpie'
$ alias https='docker run -ti --rm -v ~/.netrc:/root/.netrc --entrypoint=https alpine/httpie'
```

A `.netrc` file must exist at `~` on the host.

`/root/.netrc` is used because httpie is run as root in the container, and it
looks to the user's home directory (`/root`) for the `.netrc` file.

To use and persist a [`.httpie`](https://httpie.org/docs#config) configuration
directory:

```bash
$ alias http='docker run -ti --rm -v ~/.httpie:/root/.httpie alpine/httpie'
$ alias https='docker run -ti --rm -v ~/.httpie:/root/.httpie --entrypoint=https alpine/httpie'
```

The `~/.httpie` directory on the host will be created automatically if it does
not exist already. You will notice a `~/.httpie/config.json` is created by
httpie if one did not exist.

This will create a temporary alias. In order to make it persist reboots,
you can append this exact line to your `~/.bashrc` (or similar) like this:

```bash
$ alias http >> ~/.bashrc
$ alias https >> ~/.bashrc
```

Running HTTPie is as simple as invoking it like this:

> *From [the official examples](https://github.com/jakubroztocil/httpie#examples):*

Hello World:

```bash
$ https httpie.io/hello
```

Custom [HTTP method](https://httpie.io/docs#http-method), [HTTP headers](https://httpie.io/docs#http-headers) and [JSON](https://httpie.io/docs#json) data:


```bash
$ http PUT example.org X-API-Token:123 name=John
```

Submitting forms:

```bash
$ http -f POST example.org hello=World
```

Upload a file using redirected input:

```bash
$ http example.org < file.json
```

Download a file and save it via redirected output:

```bash
$ http example.org/file > file
```

You can supply any number of [HTTPie arguments](https://github.com/jakubroztocil/httpie#readme)
that will be passed through unmodified.

### Help

HTTPie has a fairly [extensive documentation](https://github.com/jakubroztocil/httpie#readme) available.
Also, you can use its included help output:

```bash
$ http --help
```

# The Processes to build this image

* Enable Travis CI cronjob on this repo to run build daily on master branch
* Check if there are new tags/releases announced via Github [httpie](https://github.com/httpie/httpie) REST API
* Match the exist docker image tags via Hub.docker.io REST API
* If not matched, build the image with latest version as tag and push to hub.docker.com
