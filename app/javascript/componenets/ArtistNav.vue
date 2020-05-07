<template>
    <section id="details_container" class="animated" v-if="show">
        <h1> {{artist.name}}'s Catalogue</h1>
        <div class="tabs">
            <ul>
                <li
                    @click="selected_tab = 0"
                    v-bind:class="{ 'is-active': selected_tab === 0 }"
                >
                    <a>Tracks</a>
                </li>
                <li
                    @click="selected_tab = 1"
                    v-bind:class="{ 'is-active': selected_tab === 1 }"
                >
                    <a>Revenues</a>
                </li>
            </ul>
        </div>
        <div v-show="selected_tab === 0" class="animated fadeIn">
            <artist-details :artist="artist" class="animated fadeIn"/>
        </div>

        <div v-show="selected_tab === 1" class="animated slideInRight">
            <revenues :artist="artist" />
        </div>
    </section>
</template>

<script>
    import ArtistDetails from "./ArtistDetails";
    import Revenues from "./Revenues";

    export default {
    name: "ArtistNav",
    props: {
        artist: {
            type: Object,
            required: true,
        },
    },
    components:{ ArtistDetails, Revenues },
    data() {
        return {
            show: true,
            selected_tab: 0
        }
    },
    methods: {
        entrance() {
            this.show = false;
            const el_classes = document.getElementById("details_container").classList;

            el_classes.add("fadeInDown");
            this.show = true
            setTimeout(() => {
                el_classes.remove("fadeInDown");
            }, 800);
        },
    },
    mounted() {
        this.entrance();
    },
    watch: {
        artist() {
            this.entrance();
        }
    }
}
</script>

<style scoped>
h1 {
    color: white;
}

strong, span {
    color: #34ddec;
}
</style>