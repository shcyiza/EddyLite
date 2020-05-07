<template>
    <section class="revenue-container" v-if="statement !== null">
        <div class="revenues_segment" id="revenues_overview">
            <h2>Overall revenue</h2>
            <revenue-details :statement="statement.overview" />
        </div>
        <div class="revenues_segment" id="tracks_revenue">
            <h2>Tracks revenue</h2>
            <revenue-details :statement="statement.tracks" />
        </div>
        <div class="revenues_segment" id="releases_revenue">
            <h2>Releases revenue</h2>
            <revenue-details :statement="statement.releases" />
        </div>
    </section>
</template>

<script>
    import axios from "axios";
    import RevenueDetails from "./RevenueDetails";

    export default {
        name: "Revenues",
        props: {
            artist: {
                type: Object,
                required: true,
            },
        },
        components: {
            RevenueDetails
        },
        data() {
            return {
                statement: null
            }
        },

        methods: {
            fetchRevenues() {
                axios.get(`api/artists/${this.artist.id}/revenues`).then(resp => {
                    const { data } = resp;
                    this.statement = data;
                })
            }
        },
        mounted() {
            this.fetchRevenues();
        },
        watch: {
            artist() {
                this.fetchRevenues();
            }
        }
    }
</script>

<style scoped>
h2 {
    color: #0a1753;
    font-size: 1rem;
    font-weight: bolder;
}
.revenues_segment {
    background-color: #455788;
    min-height: 160px;
    margin: 20px;
    border-radius: 20px;
    padding: 15px;
}
</style>