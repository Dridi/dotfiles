%global ldlinkflags -z noexecstack %{lua:
sep=''
for gcc_flag in string.gmatch(macros.build_ldflags, '%S+') do
    if gcc_flag:match '^\-Wl,' then
        ld_flag=string.gsub(gcc_flag, '\-Wl,', '')
        print(sep..string.gsub(ld_flag, ',', ' '))
        sep=' '
    end
end}

%global qbe_arches  x86_64 aarch64
%global hare_arches x86_64 aarch64 riscv64

%global preview rc2

Summary:        The Hare programming language
Name:           hare
License:        GPL-3.0-only

Version:        0.24.0
Release:        1%{?preview:.%preview}%{?dist}

URL:            https://harelang.org/
Source:         https://git.sr.ht/~sircmpwn/%{name}/archive/%{version}%{?preview:-%preview}.tar.gz
Patch:          0001-Makefile-Build-haredoc-1-with-LDLINKFLAGS.patch
Patch:          0002-time-chrono-leap-seconds.list-whitespace-parsing.patch

BuildRequires:  binutils
BuildRequires:  harec
BuildRequires:  make
BuildRequires:  qbe
BuildRequires:  scdoc
BuildRequires:  tzdata

Requires:       hare-stdlib = %{version}-%{release}
Requires:       harec
Requires:       tzdata

# See cross toolchain in config.mk below
Requires:       gcc
Requires:       binutils
%{lua:
for arch in string.gmatch(macros.hare_arches, '%S+') do
    if arch ~= macros._arch then
        print("Requires: binutils-"..arch.."-linux-gnu\n")
    end
end}

# TODO: submit to qbe package
ExclusiveArch:  %{qbe_arches}


%description
Hare is a systems programming language.


%package stdlib
Summary:        The Hare standard library
License:        MPL-2.0


%description stdlib
The standard library for the Hare programming language.


%prep
%autosetup -p1 -n %{name}-%{version}%{?preview:-%preview}

tee config.mk <<'EOF'
PREFIX = %{_prefix}
BINDIR = %{_bindir}
MANDIR = %{_mandir}
SRCDIR = %{_usrsrc}
STDLIB = $(SRCDIR)/hare/stdlib
HAREPATH = $(STDLIB):$(SRCDIR)/hare/third-party
VERSION = %{version}-%{release}
PLATFORM = %{_host_os}
ARCH = %{_arch}
HAREFLAGS =
HAREC = harec
HARECFLAGS =
QBE = qbe
QBEFLAGS =
AS = %{__as}
AR = %{__ar}
LD = %{__ld}
LDFLAGS = %{build_ldflags}
LDLINKFLAGS = %{ldlinkflags}
SCDOC = scdoc
HARECACHE = .cache
BINOUT = .bin
%{lua:
for arch in string.gmatch(macros.hare_arches, '%S+') do
    local host = arch.."-linux-gnu-"
    local host_as = "as"
    local host_ar = "ar"
    local host_cc = "cc"
    local host_ld = "ld"
    if arch == macros._arch then
        host = ""
        host_as = macros.__as
        host_ar = macros.__ar
        host_cc = macros.__cc
        host_ld = macros.__ld
    end
    print(string.upper(arch).."_AS = "..host..host_as.."\n")
    print(string.upper(arch).."_AR = "..host..host_ar.."\n")
    print(string.upper(arch).."_CC = "..host..host_cc.."\n")
    print(string.upper(arch).."_LD = "..host..host_ld.."\n")
end}
EOF


%build
%make_build


%install
%make_install
mkdir %{buildroot}%{_usrsrc}/%{name}/third-party

mkdir -p %{buildroot}/%{rpmmacrodir}
tee >%{buildroot}/%{rpmmacrodir}/macros.%{name} <<EOF
# Architectures where hare(1) can run
%%hare_build_arches %{qbe_arches}

# Architectures that hare(1) can compile programs for
%%hare_host_arches %{hare_arches}
EOF


%check
%make_build check


%files
%doc README.md
%license cmd/COPYING
%{_bindir}/%{name}*
%{_mandir}/man1/%{name}*
%{_mandir}/man5/%{name}*
%{rpmmacrodir}/macros.%{name}


%files stdlib
%doc README
%license COPYING
%{_usrsrc}/%{name}/


%changelog
* Sun Feb 11 2024 Dridi Boukelmoune <dridi@fedoraproject.org> - 0.24.0-1.rc2
- Update to Hare 0.24.0-rc2

* Mon May 08 2023 Dridi Boukelmoune <dridi@fedoraproject.org> - 0^20230506gitb218a528-1
- Initial packaging
