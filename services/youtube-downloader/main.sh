download(){
	local videos_path=$(xdg-user-dir VIDEOS) # ~/Videos

	if [ -z "$1" ]; then
		echo "Please, provide a URL ..."
		return 1
	fi

	if ! command -v yt-dlp &> /dev/null; then
		echo "yt-dlp could not be found, please install it first"
		return 1
	fi

	mkdir -p "${videos_path}/YouTube"
	yt-dlp -f mp4 -o "${videos_path}/YouTube/%(title)s.%(ext)s" "$1"
}
