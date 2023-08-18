%global debug_package %{nil}

Name:           unrar
Version:        6.2.10
Release:        1%{?dist}
Summary:        RAR archive extractor

License:        BSD and PublicDomain and Other
URL:            https://www.rarlab.com/
Source:         %{url}/rar/%{name}src-%{version}.tar.gz

BuildRequires:  gcc-c++

%description
Free of charge %{summary}.


%prep
%autosetup -n %{name}


%build
%make_build STRIP=%{_bindir}/true


%install
%make_build install DESTDIR=%{buildroot}/%{_prefix}


%files
%license acknow.txt
%{_bindir}/unrar


%changelog
* Fri Aug 18 2023 Dridi Boukelmoune <dridi@fedoraproject.org> - 6.2.10-1
- Bump version to 6.2.10

* Tue Oct 16 2018 Dridi Boukelmoune <dridi@fedoraproject.org> - 5.6.8-1
- Initial spec
