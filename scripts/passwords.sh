

# Function to generate a random password
generate_password() {
    local length=$1
    local complexity=$2
    local characters=''

    if [[ $complexity == *"l"* ]]; then
        characters+='abcdefghijklmnopqrstuvwxyz'
    fi
    if [[ $complexity == *"u"* ]]; then
        characters+='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    fi
    if [[ $complexity == *"d"* ]]; then
        characters+='0123456789'
    fi
    if [[ $complexity == *"s"* ]]; then
        characters+='!@#$%^&*()'
    fi

    if [[ -z $characters ]]; then
        echo "Invalid complexity criteria. Please specify at least one of 'l', 'u', 'd', or 's'."
        return 1
    fi

    password=$(LC_ALL=C tr -dc "$characters" < /dev/urandom | fold -w "$length" | head -n 1)
    echo "$password"
}

# Parsing command-line arguments
while getopts ":l:c:" opt; do
    case $opt in
        l) length=$OPTARG ;;
        c) complexity=$OPTARG ;;
        :) echo "Option -$OPTARG requires an argument." >&2; exit 1 ;;
        *) echo "Invalid option -$OPTARG." >&2; exit 1 ;;
    esac
done

# Setting default values if arguments are not provided
length=${length:-8}
complexity=${complexity:-lud}

# Generating the password
password=$(generate_password "$length" "$complexity")
if [[ $? -ne 0 ]]; then
    exit 1
fi

echo "Generated Password: $password"
