require 'rake'
require 'rubygems'
require 'spec/rake/spectask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'

require 'spec'
require 'cuecat'

desc "Default: run specs"
task :default => :spec

desc "Run all the specs for the notamock plugin."
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--colour']
  t.rcov = true
  t.rcov_opts = ["--exclude \"spec/*,gems/*\""]
end

desc "Generate documentation for the notamock plugin."
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'cuecat'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('MIT-LICENSE')
  rdoc.rdoc_files.include('CHANGELOG')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

PKG_NAME           = "cuecat"
PKG_VERSION        = CueCat::Version::String
PKG_FILE_NAME      = "#{PKG_NAME}-#{PKG_VERSION}"
RUBY_FORGE_PROJECT = "yob-projects"

spec = Gem::Specification.new do |s|
  s.name              = PKG_NAME
  s.version           = PKG_VERSION
  s.summary           = "a (very) small library for working with cuecat codes"
  s.description       = "a (very) small library for working with cuecat codes"
  s.author            = "James Healy"
  s.email             = "jimmy@deefa.com"
  s.homepage          = "http://github.com/yob/cuecat/tree/master"
  s.has_rdoc          = true
  s.rdoc_options     << "--title" << "CueCat" <<
                        "--line-numbers"
  s.rubyforge_project = RUBY_FORGE_PROJECT
  s.test_files        = FileList["spec/**/*_spec.rb"]
  s.files             = FileList[
    "lib/**/*.rb",
    "MIT-LICENSE",
    "README.rdoc",
    "CHANGELOG"
  ]

  s.add_dependency('ean13', '>= 1.0')
  s.add_dependency('upc', '>= 1.0')
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = false
  p.need_zip = false
end
