#!/usr/bin/env perl
use Mojo::Base -strict;

use Test::More tests => 10;

use Mojolicious::Lite;
use Test::Mojo;

plugin 'PPI', 'toggle_button' => 1;

get '/file'   => 'file';
get '/toggle' => 'toggle';

my $t = Test::Mojo->new;
$t->get_ok('/file')
  ->status_is(200)
  ->text_is('span.symbol' => '@world')
  ->element_exists('span.line_number')
  ->element_exists_not('input');

$t->get_ok('/toggle')
  ->status_is(200)
  ->text_is('span.symbol' => '@world')
  ->element_exists('span.line_number')
  ->element_exists('input');

__DATA__

@@ file.html.ep
% title 'Inline';
% layout 'basic';
Hello <%= ppi 't/test.pl', toggle_button => 0 %>

@@ toggle.html.ep
% title 'Inline';
% layout 'basic';
Hello <%= ppi 't/test.pl' %>

@@ layouts/basic.html.ep
  <!doctype html><html>
    <head>
      <title><%= title %></title>
      %= javascript 'ppi.js'
      %= stylesheet 'ppi.css'
    </head>
    <body><%= content %></body>
  </html>