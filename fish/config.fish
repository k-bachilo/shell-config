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
            touch "$current_dir/$arg.go"
        else
            touch "$arg.go"
        end
    end
end

function gg
    go get $argv
end

function gmi
    go mod init $argv
end
