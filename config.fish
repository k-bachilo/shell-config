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

function gg
    set go_mod_file "go.mod"
    if test -f ./$go_mod_file
        go get $argv
    else if test -d $argv[1]
        cd $argv[1]
        if test -f ./$go_mod_file
            go get $argv[2..-1]
        end
    end
end

function gi
    set dir $argv[1]
    mkdir -p $dir
    cd $dir
    go mod init $dir
end

function gt
    set go_mod_file "go.mod"
    if test -f ./$go_mod_file
        go mod tidy
    else if test -d $argv[1]
        cd $argv[1]
        if test -f ./$go_mod_file
            go mod tidy
        end
    end
end

set -Ux GOPATH "$HOME/Workspace/.dependencies"
set -Ux PATH "$HOME/Workspace/.dependencies/bin"
set -Ux GOCACHE "$HOME/Workspace/.dependencies/cache"
set -Ux GOMODCACHE "$HOME/Workspace/.dependencies/pkg/mod"
