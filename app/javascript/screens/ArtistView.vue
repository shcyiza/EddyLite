<template>
    <section class="a-container">
        <div class="columns">
            <div class="artists-list column is-2">
                <div class="navbar-brand">
                    <img :src="logo_url" height="28" alt="logo" />
                    <p>lite</p>
                </div>

                <h1>Artists</h1>
                <span class="material-icons" style="color: #0a1753">
                    search
                </span>
                <input type="text" class="myInput" v-model="search_input" placeholder="Search for artist..." title="Type in a name">
                <div v-for="artist of searchResults" :key="artist.id">
                    <div class="artist-instance"
                            @click="selected = artist"
                            v-bind:class="{ active: selected === artist }"
                    >
                        {{artist.name}}
                    </div>

                </div>
            </div>
            <div class="artist-details column is-10">
                <div v-if="selected === null">
                    <h2 class="placeholder">
                        <span class="material-icons">
                            headset
                        </span>
                        Please select an artist...
                    </h2>
                </div>

                <artist-nav v-else :artist="selected" />
            </div>
        </div>
    </section>
</template>

<script>
    import ArtistNav from "../componenets/ArtistNav";

    export default {
        name: "ArtistView",
        props: {
            artists: {
                type: Array,
                required: true
            },
            logo_url: {
                type: String,
                required: true
            },
        },
        components: { ArtistNav },
        data() {
            return {
                selected: null,
                search_input: ""
            }
        },
        computed: {
            searchResults() {
                return !this.search_input
                    ? this.artists.filter(artist => {
                        return artist.name.toLowerCase().includes(this.search_input.toLowerCase())
                    })
                    : this.search_input
            }
        }
    }
</script>

<style scoped>
p {
    font-family: Oswald;
    color: #0a1753;
}
.a-container {
    height: 99vh;
}
.artist-details{
    padding: 25px;
    height: 99vh;
    background: linear-gradient(159deg, rgba(0,0,32,1) 51%, rgba(10,23,83,1) 73%);
    border-radius: 0 0 0 40px;
    overflow: auto;
}
.artists-list {
    padding-right: 0;
}
.artist-instance{
    text-align: right;
    width: 97%;
    margin-right: 0;
    margin-left: 6px;
    margin-bottom: 15px;
    height: 60px;
    background: transparent;
    color: #0a0a0a;
    font-size: larger;
    border: 0;
    border-bottom: #0a1753 solid 2px;
    border-radius:15px 0 0 15px;
    padding: 10px;
    font-weight: bolder;
}

.artist-instance:hover, .active{
    background: linear-gradient(141deg, #65736d 0%, #126b73 51%, rgba(22, 79, 102, 0) 75%);
    color: white;
    cursor: pointer;
    -webkit-box-shadow: -15px 12px 14px -9px rgba(0,0,0,0.75);
    -moz-box-shadow: -15px 12px 14px -9px rgba(0,0,0,0.75);
    box-shadow: -15px 12px 14px -9px rgba(0,0,0,0.75);
}

.active, .active:hover {
    background: #000020;
    color: white;
    cursor: pointer;
    -webkit-box-shadow: -15px 12px 14px -9px rgba(0,0,0,0.75);
    -moz-box-shadow: -15px 12px 14px -9px rgba(0,0,0,0.75);
    box-shadow: -15px 12px 14px -9px rgba(0,0,0,0.75);
}
.placeholder {
    font-size: 2em;
    margin-top: 300px;
    text-align: center;
}
</style>