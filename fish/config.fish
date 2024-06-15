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
