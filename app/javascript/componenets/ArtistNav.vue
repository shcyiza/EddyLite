<template>
    <section id="details_container" class="animated" v-show="show">
        <h1> {{artist.name}}</h1>
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

        <artist-details :artist="artist" v-show="selected_tab === 0" class="animated fadeIn"/>

        <div v-show="selected_tab === 1" class="animated slideInRight">Revenues</div>
    </section>
</template>

<script>

    import ArtistDetails from "./ArtistDetails";

    export default {
    name: "ArtistNav",
    props: ['artist'],
    components:{ ArtistDetails },
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
            this.selected_tab = 0;
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