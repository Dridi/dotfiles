# Generated from erubis-2.7.0.gem by gem2rpm -*- rpm-spec -*-
%global gem_name erubis

Name: rubygem-%{gem_name}
Version: 2.7.0
Release: 1%{?dist}
Summary: a fast and extensible eRuby implementation which supports multi-language
License: MIT
URL: http://www.kuwata-lab.com/erubis/
Source0: https://rubygems.org/gems/%{gem_name}-%{version}.gem
BuildRequires: ruby(release)
BuildRequires: rubygems-devel
BuildRequires: ruby
BuildArch: noarch

%description
Erubis is an implementation of eRuby and has the following features:
* Very fast, almost three times faster than ERB and about 10% faster than
eruby.
* Multi-language support (Ruby/PHP/C/Java/Scheme/Perl/Javascript)
* Auto escaping support
* Auto trimming spaces around '<% %>'
* Embedded pattern changeable (default '<% %>')
* Enable to handle Processing Instructions (PI) as embedded pattern (ex. '<?rb
... ?>')
* Context object available and easy to combine eRuby template with YAML
datafile
* Print statement available
* Easy to extend and customize in subclass
* Ruby on Rails support.


%package doc
Summary: Documentation for %{name}
Requires: %{name} = %{version}-%{release}
BuildArch: noarch

%description doc
Documentation for %{name}.

%prep
%setup -q -n %{gem_name}-%{version}

%build
# Create the gem as gem install only works on a gem file
gem build ../%{gem_name}-%{version}.gemspec

# %%gem_install compiles any C extensions and installs the gem into ./%%gem_dir
# by default, so that we can move it into the buildroot in %%install
%gem_install

%install
mkdir -p %{buildroot}%{gem_dir}
cp -a .%{gem_dir}/* \
        %{buildroot}%{gem_dir}/


mkdir -p %{buildroot}%{_bindir}
cp -a .%{_bindir}/* \
        %{buildroot}%{_bindir}/

find %{buildroot}%{gem_instdir}/bin -type f | xargs chmod a+x

%check
pushd .%{gem_instdir}
# Run the test suite.
popd

%files
%dir %{gem_instdir}
%{_bindir}/erubis
%{gem_instdir}/CHANGES.txt
%license %{gem_instdir}/MIT-LICENSE
%{gem_instdir}/benchmark
%{gem_instdir}/bin
%{gem_instdir}/contrib
%{gem_libdir}
%{gem_instdir}/setup.rb
%exclude %{gem_cache}
%{gem_spec}

%files doc
%doc %{gem_docdir}
%doc %{gem_instdir}/README.txt
%doc %{gem_instdir}/doc-api
%doc %{gem_instdir}/doc
%{gem_instdir}/examples
%{gem_instdir}/test

%changelog
* Thu Apr 27 2023 Dridi Boukelmoune <dridi.boukelmoune@gmail.com> - 2.7.0-1
- Initial package
