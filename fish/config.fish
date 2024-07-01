# Httpie
function hg
    http GET ":$argv[1]" $argv[2..-1]
end

function hp
    http POST ":$argv[1]" $argv[2..-1]
end

function hd
    http DELETE ":$argv[1]" $argv[2..-1]
end

function hu
    http PUT ":$argv[1]" $argv[2..-1]
end

function ht
    http PATCH ":$argv[1]" $argv[2..-1]
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

function gmi
    set dir $argv[1]
    mkdir -p $dir
    cd $dir
    go mod init $dir
end
