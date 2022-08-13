export PATH="/opt/homebrew/bin:$PATH"
export LIBRARY_PATH="/opt/homebrew/lib:$LIBRARY_PATH"

# icu4c
export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/sbin:$PATH"

export LDFLAGS="-L/opt/homebrew/opt/icu4c/lib"
export CPPFLAGS="-I/opt/homebrew/opt/icu4c/include"

export PKG_CONFIG_PATH="/opt/homebrew/opt/icu4c/lib/pkgconfig"

# libxml
export PATH="/opt/homebrew/opt/libxml2/bin:$PATH"

#export LDFLAGS="-L/opt/homebrew/opt/libxml2/lib"
#export CPPFLAGS="-I/opt/homebrew/opt/libxml2/include"

#export PKG_CONFIG_PATH="/opt/homebrew/opt/libxml2/lib/pkgconfig"
