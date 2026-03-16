#!/usr/bin/env bash

API_URL="https://mobility-prices.ok.dk/api/v1/fuel-prices"

# Liste over byer du vil filtrere på
CITIES=("Odense" "København" "Aarhus")

echo "Henter OK benzinpriser..."

# Hent API-data én gang
DATA=$(curl -s "$API_URL")

if [ -z "$DATA" ]; then
    echo "Fejl: Ingen data modtaget fra API."
    exit 1
fi

# Loop gennem byer og filtrér
for CITY in "${CITIES[@]}"; do
    echo ""
    echo "=== $CITY ==="

    echo "$DATA" | jq -r --arg CITY "$CITY" '
      .items[]
      | select(.city | ascii_downcase == ($CITY | ascii_downcase))
      | {
          adresse: (.street + " " + .house_number),
          postnr: .postal_code,
          by: .city,
          priser: (.prices | map({produkt: .product_name, pris: .price}))
        }
      | "Adresse: \(.adresse)\nPostnr/By: \(.postnr) \(.by)\n" +
        (
          .priser[]
          | "\(.produkt): \(.pris) kr\n"
        )
    '

    sleep 1
done
