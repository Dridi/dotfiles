%global gem_name tmuxinator

Name: rubygem-%{gem_name}
Version: 3.0.5
Release: 1%{?dist}
Summary: Create and manage complex tmux sessions easily
License: MIT
URL: https://github.com/%{gem_name}/%{gem_name}
Source0: https://rubygems.org/gems/%{gem_name}-%{version}.gem
Requires: tmux
BuildRequires: ruby(release)
BuildRequires: rubygems-devel >= 1.8.23
BuildRequires: ruby >= 2.6.7
BuildArch: noarch


%description
Ruby gem to create and manage complex tmux sessions easily.


%package doc
Summary: Documentation for %{name}
Requires: %{name} = %{version}-%{release}
BuildArch: noarch


%description doc
Documentation for %{name}.


%package -n %{gem_name}
Summary: Documentation for %{name}
Requires: %{name} = %{version}-%{release}
BuildArch: noarch


%description -n %{gem_name}
Create and manage complex tmux sessions easily.


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

# Install shell completion
install -d -m 0755 %{buildroot}%{_datadir}/fish/vendor_completions.d/
install -d -m 0755 %{buildroot}%{_datadir}/zsh/site-functions/
install -d -m 0755 %{buildroot}%{_sysconfdir}/bash_completion.d/

install -p -m 0644 completion/*.bash %{buildroot}%{_sysconfdir}/bash_completion.d/
install -p -m 0644 completion/*.fish %{buildroot}%{_datadir}/fish/vendor_completions.d/
install -p -m 0644 completion/*.zsh  %{buildroot}%{_datadir}/zsh/site-functions/


%check
# Skipping the test suite, I don't have time to maintain missing build
# dependencies on top of tmuxinator. The list of test dependencies can
# be found by running gem2rpm.


%files
%dir %{gem_instdir}
%{gem_instdir}/bin
%{gem_libdir}
%{gem_spec}

%exclude %{gem_instdir}/completion
%exclude %{gem_cache}


%files doc
%doc %{gem_docdir}
%{gem_instdir}/spec


%files -n %{gem_name}
%{_bindir}/%{gem_name}
%{_datadir}/fish/vendor_completions.d/
%{_datadir}/zsh/site-functions/
%{_sysconfdir}/bash_completion.d/


%changelog
* Thu Apr 23 2020 Dridi Boukelmoune <dridi.boukelmoune@gmail.com> - 1.1.4-1
- Initial spec adapted from gem2rpm
