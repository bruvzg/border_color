def can_build(env, platform):
    return (platform == "osx") or (platform == "windows") or (platform == "linuxbsd")

def configure(env):
    pass
