# Generated from xdg-2.2.5.gem by gem2rpm -*- rpm-spec -*-
%global gem_name xdg

Name: rubygem-%{gem_name}
Version: 2.2.5
Release: 1%{?dist}
Summary: XDG provides an interface for using XDG directory standard
License: BSD-2-Clause
URL: https://github.com/bkuhlmann/xdg
Source0: https://rubygems.org/gems/%{gem_name}-%{version}.gem
BuildRequires: ruby(release)
BuildRequires: rubygems-devel
BuildRequires: ruby
BuildArch: noarch

%description
XDG provides an interface for using XDG directory standard.


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



%check
pushd .%{gem_instdir}
# Run the test suite.
popd

%files
%dir %{gem_instdir}
%{gem_instdir}/.index
%exclude %{gem_instdir}/.yardopts
%{gem_instdir}/DEMO.md
%license %{gem_instdir}/LICENSE.txt
%{gem_instdir}/demo
%{gem_libdir}
%exclude %{gem_cache}
%{gem_spec}

%files doc
%doc %{gem_docdir}
%doc %{gem_instdir}/HISTORY.md
%doc %{gem_instdir}/README.md
%{gem_instdir}/test

%changelog
* Thu Apr 23 2020 Dridi Boukelmoune <dridi.boukelmoune@gmail.com> - 2.2.5-1
- Initial package
