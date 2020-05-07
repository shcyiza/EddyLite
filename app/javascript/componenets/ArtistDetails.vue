<template>
    <section>
        <input type="text" class="myInput"
               placeholder="Search tracks or by release year or title..."
               title="Type in a name"
               v-model="search_input"
        />
        <div class="flex-tracks">
            <div v-for="track of searchResults" :key="track.id" class="flex-track">
                <div class="cover-art">
                    <img :src="(track.releases[1] || track.releases[0]).cover_art_url"/>
                </div>
                <div class="track-description">
                    <strong>{{track.title}}</strong>
                    <br>
                    Releases: <span>{{track.releases.length}}</span>
                    <br>
                    Last released: <span>{{track.releases.sort((a, b) => b-a)[0].year}}</span>
                </div>
            </div>
        </div>
    </section>
</template>

<script>
import axios from "axios";

export default {
    name: "ArtistDetails",
    props: {
        artist: {
            type: Object,
            required: true,
        },
    },
    data() {
        return {
            tracks: null,
            search_input: "",
        }
    },
    computed: {
        searchResults() {
            const search_input = this.search_input.toLowerCase();
            return this.search_input
                ? this.tracks.filter(
                    t =>
                        t.title.toLowerCase().includes(search_input)
                        || t.releases.find(r =>  r.year === Number(search_input))
                )
                : this.tracks
        }
    },
    methods: {
        fetchTracks() {
            axios.get(`/artists/${this.artist.id}/tracks`).then(resp => {
                const { data } = resp;
                this.tracks = data;
            })
        },
    },
    mounted() {
        this.fetchTracks();
    },
    watch: {
        artist() {
            this.fetchTracks();
        }
    }
}
</script>

<style scoped>
h1 {
    color: white;
}
.flex-tracks {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: center;
    overflow: auto;
}
.flex-tracks > .flex-track {
    flex: 33%; /*grow | shrink | basis */
    text-align: center;
    margin-bottom: 40px;
    max-width: 308px;
}
.flex-track:hover {
    background: linear-gradient(141deg, #65736d 0%, #126b73 51%, rgba(22, 79, 102, 0) 75%);
    color: black;
    border-radius: 20px;
    cursor: pointer;
}
strong, span {
    color: #34ddec;
}
.cover-art {
    text-align: center;
    width: 200px;
    height: 200px;
    margin-left: 55px;
}
.track-description{
    margin-left: 55px;
    text-align: center;
    width: 200px;
    font-size: 13px;
}
</style>