<template>
    <section class="columns">
        <div class="column is-6">
            <h1>Total: <span class="amount">{{toUsd(statement.revenues)}}</span></h1>
            <span class="share_overview">
            Artist share
            <span class="amount">{{toUsd(statement.artist_share)}}</span>
            ({{percentOf(statement.artist_share)}}%) |
            </span>
                <span class="share_overview">
                Label share
                    <span class="amount">
                        {{toUsd(statement.label_share)}}
                    </span>
                ({{percentOf(statement.label_share)}}%)
            </span>
        </div>
        <div class="column is-6" v-if="statement.details">
            <ul>
                <li v-for="saleable of statement.details" class="share_overview">
                    <span class="title">
                        {{saleable.item.title || saleable.item.release_title}}
                    </span>
                    has made
                    <span class="amount">
                        {{toUsd(saleable.revenues)}}
                    </span>
                    ({{percentOf(saleable.revenues)}}%)
                </li>
            </ul>
        </div>
    </section>
</template>

<script>

    const USD = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
    });

    const normalize = amount => Math.round(amount / 10**4) /100

    export default {
        name: "Revenue",
        props: {
            statement: {
                type: Object,
                required: true,
            },
        },
        computed: {
            toUsd() {
                return (amount) => USD.format(normalize(amount))
            },
            percentOf() {
                return (share, total = this.statement.revenues) => total && Math.round((normalize(share)/normalize(total)) * 100)
            }
        },
    }
</script>

<style scoped>
.share_overview {
    color: #0a1753;
    font-size: 1rem;
}

.amount {
    color: white;
    font-weight: bolder;
}
.title {
    color: #34ddec;
    font-weight: bolder;
    font-size: 16px;
}
</style>