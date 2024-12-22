# def main [--lang (-l)] {
#     let topic_constraint = if $lang { "lang" } else { "none" }
# 
#     let topic = if $topic_constraint == "lang" {
#         ["go" "rust" "c"] 
#         | str join "\n"
#         | ^fzf 
#         | str trim
#     } else {
#         ^curl -s cht.sh/:list 
#         | ^fzf
#         | str trim
#     }
# 
#     if ($topic | is-empty) {
#         exit 0
#     }
# 
#     let sheet = (^curl -s $"cht.sh/($topic)/:list"
#         | ^fzf
#         | str trim)
# 
#     if ($sheet | is-empty) {
#         ^curl -s $"cht.sh/($topic)?style=rrt"
#         | ^bat
#         exit 0
#     }
# 
#     ^curl -s $"cht.sh/($topic)/($sheet)?style=rrt"
#     | ^bat
# }


def main [--lang (-l)] {
    mut query = ""
    let topic_constraint = if $lang { "lang" } else { "none" }
    
    # Select topic/language
    let topic = if $topic_constraint == "lang" {
        ["go" "rust" "c" "python" "javascript" "java" "cpp" "typescript"]
        | str join "\n"
        | ^fzf --prompt="Select language: "
        | str trim
    } else {
        # Get all topics and format them properly
        ^curl -s "cht.sh/:list" 
        | lines 
        | str trim
        | str join "\n"
        | ^fzf --prompt="Select topic: "
        | str trim
    }
    
    if ($topic | is-empty) {
        return
    }
    
    print $"Selected topic: ($topic)"
    
    # Get list of available sheets/commands for the topic
    let sheets = (^curl -s $"cht.sh/($topic)/:list" 
        | lines 
        | str trim 
        | str join "\n")
        
    if ($sheets | is-empty) {
        print $"No sheets found for ($topic)"
        return
    }
    
    # Let user select a specific sheet or enter a custom query
    let selected = ($sheets 
        | ^fzf --prompt="Select command or press CTRL-C to enter custom query: " --print-query
        | str trim)
    
    if ($selected | is-empty) {
        print "No selection made"
        return
    }

    # Parse selection - fzf returns query in first line, selection in second line
    let selection_lines = ($selected | lines)
    let user_query = ($selection_lines | first)
    let sheet = if ($selection_lines | length) > 1 { 
        $selection_lines | last
    } else {
        $user_query  # Use query if no selection was made
    }
    
    # Handle either selected sheet or custom query
    if ($sheet | is-empty) {
        ^curl -s $"cht.sh/($topic)/($user_query)?T" | ^less -R
    } else {
        # If it's a sheet/command with spaces, replace them with '+'
        let formatted_sheet = ($sheet | str replace --all " " "+")
        ^curl -s $"cht.sh/($topic)/($formatted_sheet)?T" | ^less -R
    }
}
