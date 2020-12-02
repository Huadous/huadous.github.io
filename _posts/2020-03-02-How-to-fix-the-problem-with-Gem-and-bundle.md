---
title: RubyGems domestic mirror
date: 2020-03-02 20:53:00 +0800
categories: [Learning, Self-study, RubyGems]
tags: [Ruby, RubyGems, Bundle]
---


## Using domestic mirror to solve bad connection
---

If you find it is difficult to connect to RubyGems or Download from RubyGems, you must have to try this [RubyGems-RubyChine](https://gems.ruby-china.com/)

## How to use?
---

Please use a newer version of RubyGems whenever possible, 2.6.x or higher is recommended.

``` console
$ gem update --system # Please use VPN, SSR, etc here
$ gem -v
2.6.3
```

```console
$ gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
$ gem sources -l
https://gems.ruby-china.com
# Make sure only gems.ruby-china.com
```

## If you use Gemfile and Bundler (for example: Rails project)
---

You can use the Bundler's [Gem source code's mirror command](http://bundler.io/v1.5/bundle_config.html#gem-source-mirrors).

```console
$ bundle config mirror.https: //rubygems.org https://gems.ruby-china.com
```

By this way, you don't need to change the source of your Gemfile.

```console
source 'https://rubygems.org/'
gem 'rails', '4.2.5'
...
```

## SSL certificate error
---

Under normal circumstances, you will not encounter SSL certificate errors unless your Ruby is installed incorrectly.

If you encounter an SSL certificate problem and you cannot resolve it, modify the `~ / .gemrc` file and add the `ssl_verify_mode: 0` configuration so that RubyGems can ignore SSL certificate errors.

```console
---
: sources:
-https://gems.ruby-china.com
: ssl_verify_mode: 0
```

If you are concerned about the security of Gem download, please install Ruby and OpenSSL correctly. It is recommended to use [this RVM installation script](https://github.com/huacnlee/init.d/blob/master/install_rvm) to install Ruby when deploying a Linux server.

## Other instructions
---

`Bundler :: GemspecError: Could not read gem at /home/xxx/.rvm/gems/ruby-2.1.8/cache/rugged-0.23.3.gem. It may be corrupted.` This type of error is due to network reasons and downloaded a bad file to the local. Please delete that file directly.


Please cherish the community resources. Do not make a secondary mirroring website based on this mirror. We will regularly check the CDN request volume statistics. IPs with excessive daily requests (over 20G traffic) will be permanently blocked.