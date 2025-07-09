if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Golang
function g
    set current_dir ""
    for arg in $argv
        if test $arg = ","
            set current_dir ""
        else if string match -qr "/" $arg
            set current_dir $arg
            mkdir -p $current_dir
        else if test -n $current_dir
            set filename "$current_dir/$arg.go"
            touch $filename
            set package_name (string split -m1 "/" $current_dir)[-1]
            echo "package $package_name" > $filename
        else
            set filename "$arg.go"
            touch $filename
            echo "package $arg" > $filename
        end
    end
end

set -Ux GOPATH "$HOME/Workspace/.dependencies"
set -Ux GOCACHE "$HOME/Workspace/.dependencies/cache"
set -Ux GOMODCACHE "$HOME/Workspace/.dependencies/pkg/mod"
set -Ux GOBIN "$HOME/Workspace/.dependencies/bin"
set -Ux PATH /opt/homebrew/bin $GOBIN $PATH
