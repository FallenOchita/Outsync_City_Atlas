const searchInput = document.getElementById("search");
const postalResults = document.getElementById("postal-results");
const streetResults = document.getElementById("street-results");
const catalogStatus = document.getElementById("catalog-status");
const postalStatus = document.getElementById("postal-status");
const postalCount = document.getElementById("postal-count");
const streetCount = document.getElementById("street-count");

let catalog = { postals: [], streets: [] };

function makeEmpty(message) {
    const node = document.createElement("div");
    node.className = "empty-state";
    node.textContent = message;
    return node;
}

function render() {
    const query = searchInput.value.trim().toLocaleLowerCase();
    const postals = catalog.postals.filter((item) => {
        const names = (item.streets || []).map((street) =>
            typeof street === "string" ? street : street.name
        );
        return String(item.code || "").toLowerCase().includes(query)
            || String(item.district || "").toLowerCase().includes(query)
            || names.some((name) => String(name || "").toLowerCase().includes(query));
    });

    const streets = catalog.streets.filter((street) =>
        String(street.name || "").toLowerCase().includes(query)
        || String(street.district || "").toLowerCase().includes(query)
        || String(street.postal || "").toLowerCase().includes(query)
    );

    postalResults.replaceChildren();
    streetResults.replaceChildren();

    postalCount.textContent = `${postals.length} AREAS`;
    streetCount.textContent = `${streets.length} STREETS`;

    if (postals.length === 0) {
        postalResults.append(makeEmpty("No postal districts match this search."));
    } else {
        for (const item of postals) {
            const card = document.createElement("article");
            card.className = "postal-card";

            const code = document.createElement("div");
            code.className = "postal-code";
            code.textContent = item.code || "UNASSIGNED";

            const district = document.createElement("div");
            district.className = "postal-district";
            district.textContent = item.district || "Unnamed district";

            const note = document.createElement("div");
            note.className = "postal-note";
            note.textContent = "Outsync postal directory";

            card.append(code, district, note);
            postalResults.append(card);
        }
    }

    if (streets.length === 0) {
        streetResults.append(makeEmpty(
            "Street records have not been added yet. Add verified street names to shared/data.lua; they will appear here automatically."
        ));
    } else {
        for (const item of streets) {
            const card = document.createElement("article");
            card.className = "street-card";

            const name = document.createElement("span");
            name.className = "street-name";
            name.textContent = item.name || "Unnamed street";

            const meta = document.createElement("span");
            meta.className = "street-meta";
            meta.textContent = [item.district, item.postal].filter(Boolean).join(" • ");

            card.append(name, meta);
            streetResults.append(card);
        }
    }
}

Open77.on("atlas:state", (data) => {
    catalog = {
        postals: Array.isArray(data.postals) ? data.postals : [],
        streets: Array.isArray(data.streets) ? data.streets : []
    };

    document.getElementById("subtitle").textContent =
        data.subtitle || "POSTAL & STREET DIRECTORY";
    document.getElementById("version").textContent =
        `v${data.version || "0.1.0"}`;
    postalStatus.textContent = data.postalStatus || "UNVERIFIED";
    catalogStatus.textContent = "City directory connected";
    render();
});

searchInput.addEventListener("input", render);

// Install listeners before requesting the initial state.
Open77.emit("open77:map:ready", {});
Open77.emit("atlas:refresh", {});
