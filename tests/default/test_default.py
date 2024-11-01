def test_fixbuf_version(host):
    version = "2.5.0"
    command = """PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/netsa/lib/pkgconfig \
                 pkg-config --modversion libfixbuf"""

    cmd = host.run(command)

    assert version in cmd.stdout
