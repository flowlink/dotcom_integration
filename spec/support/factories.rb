module Factories
  class << self

    def api_key
      '0ec79156828ad21b109a616aa3ca920e'
    end

    def password
      'f22a1c177fbfd951afb4661d446b5491'
    end

    def config(args={})
      {
        'dotcom_api_key' => api_key,
        'dotcom_password' => password,
        'dotcom_last_polling_datetime' => '2011-01-01',
        'dotcom_shipping_lookup' => [{
            'UPS Ground (USD)' => '03',
            'UPS Two Day (USD)' => '02',
            'UPS One Day (USD)' => '01'
        }]
      }
    end

    def shipment(args={})
      payload["shipment"].merge(args)
    end

    def order(args={})
      payload["order"].merge(args)
    end

    def original(args={})
      payload["original"].merge(args)
    end

    def non_existent_items
      [{
        "name" => "Spree Baseball Jersey",
        "sku" => "SPR-00001",
        "external_ref" => "",
        "quantity" => 1,
        "price" => 19.99,
        "variant_id" => 8,
        "options" => {}
      }]
    end

    def existent_items
      [
        {
          "name" => "The A Pocket fit sits comfor",
          "sku" => "7FO-100169-NAK-24",
          "external_ref" => "",
          "quantity" => 1,
          "price" => 19.99,
          "variant_id" => 8,
          "options" => {}
        },
        {
          "name" => "The A Pocket fit sits comfor",
          "sku" => "7FO-100169-NAK-25",
          "external_ref" => "",
          "quantity" => 1,
          "price" => 19.99,
          "variant_id" => 20,
          "options" => {
            "tshirt-color" => "Red",
            "tshirt-size" => "Medium"
          }
        }
      ]
    end

    def payload(args={}, items = existent_items)
      {
        "shipment" => {
          "number" => "H215918586",
          "order_number" => "R619271706",
          "email" => "spree@example.com",
          "cost" => 5,
          "status" => "shipped",
          "stock_location" => nil,
          "shipping_method" => "UPS Ground (USD)",
          "tracking" => nil,
          "updated_at" => nil,
          "shipped_at" => "2013-07-30T20:08:38Z",
          "shipping_address" => {
            "firstname" => "Brian",
            "lastname" => "Quinn",
            "address1" => "7735 Old Georgetown Rd",
            "address2" => "",
            "zipcode" => "20814",
            "city" => "Bethesda",
            "state" => "Maryland",
            "country" => "US",
            "phone" => "555-123-456"
          },
          "items" => items
        },
        "order" => {
          "number" => "R61927170",
          "channel" => "spree",
          "email" => "spree@example.com",
          "currency" => "USD",
          "placed_on" => "2013-07-30T19:19:05Z",
          "updated_at" => "2013-07-30T20:08:39Z",
          "status" => "complete",
          "totals" => {
            "item" => 99.95,
            "adjustment" => 15,
            "tax" => 5,
            "shipping" => 0,
            "payment" => 114.95,
            "order" => 114.95
          },
          "line_items" => [
            {
              "name" => "Spree Baseball Jersey",
              "sku" => "SPR-00001",
              "external_ref" => "",
              "quantity" => 2,
              "price" => 19.99,
              "variant_id" => 8,
              "options" => {
              }
            },
            {
              "name" => "Ruby on Rails Baseball Jersey",
              "sku" => "ROR-00004",
              "external_ref" => "",
              "quantity" => 3,
              "price" => 19.99,
              "variant_id" => 20,
              "options" => {
                "tshirt-color" => "Red",
                "tshirt-size" => "Medium"
              }
            }
          ],
          "adjustments" => [
            {
              "name" => "Shipping",
              "value" => 5
            },
            {
              "name" => "Shipping",
              "value" => 5
            },
            {
              "name" => "North America 5.0",
              "value" => 5
            }
          ],
          "shipping_address" => {
            "firstname" => "Brian",
            "lastname" => "Quinn",
            "address1" => "7735 Old Georgetown Rd",
            "address2" => "",
            "zipcode" => "20814",
            "city" => "Bethesda",
            "state" => "Maryland",
            "country" => "US",
            "phone" => "555-123-456"
          },
          "billing_address" => {
            "firstname" => "Brian",
            "lastname" => "Quinn",
            "address1" => "7735 Old Georgetown Rd",
            "address2" => "",
            "zipcode" => "20814",
            "city" => "Bethesda",
            "state" => "Maryland",
            "country" => "US",
            "phone" => "555-123-456"
          },
          "payments" => [
            {
              "number" => 6,
              "status" => "completed",
              "amount" => 5,
              "payment_method" => "Check"
            },
            {
              "number" => 5,
              "status" => "completed",
              "amount" => 109.95,
              "payment_method" => "Credit Card"
            }
          ],
          "shipments" => [
            {
              "number" => "H215918586",
              "cost" => 5,
              "status" => "shipped",
              "stock_location" => nil,
              "shipping_method" => "UPS Ground (USD)",
              "tracking" => nil,
              "updated_at" => nil,
              "shipped_at" => "2013-07-30T20:08:38Z",
              "items" => [
                {
                  "name" => "Spree Baseball Jersey",
                  "sku" => "SPR-00001",
                  "external_ref" => "",
                  "quantity" => 1,
                  "price" => 19.99,
                  "variant_id" => 8,
                  "options" => {
                  }
                },
                {
                  "name" => "Ruby on Rails Baseball Jersey",
                  "sku" => "ROR-00004",
                  "external_ref" => "",
                  "quantity" => 1,
                  "price" => 19.99,
                  "variant_id" => 20,
                  "options" => {
                    "tshirt-color" => "Red",
                    "tshirt-size" => "Medium"
                  }
                }
              ]
            },
            {
              "number" => "H541684679",
              "cost" => 5,
              "status" => "ready",
              "stock_location" => nil,
              "shipping_method" => "UPS Ground (USD)",
              "tracking" => "4532535354353452",
              "updated_at" => nil,
              "shipped_at" => nil,
              "items" => [
                {
                  "name" => "Ruby on Rails Baseball Jersey",
                  "sku" => "ROR-00004",
                  "external_ref" => "",
                  "quantity" => 2,
                  "price" => 19.99,
                  "variant_id" => 20,
                  "options" => {
                    "tshirt-color" => "Red",
                    "tshirt-size" => "Medium"
                  }
                },
                {
                  "name" => "Spree Baseball Jersey",
                  "sku" => "SPR-00001",
                  "external_ref" => "",
                  "quantity" => 1,
                  "price" => 19.99,
                  "variant_id" => 8,
                  "options" => {
                  }
                }
              ]
            }
          ]
        },
        "original" => {
          "id" => 5,
          "number" => "R61927170",
          "item_total" => "99.95",
          "total" => "114.95",
          "state" => "complete",
          "adjustment_total" => "15.0",
          "user_id" => 1,
          "created_at" => "2013-07-29T17:42:02Z",
          "updated_at" => "2013-07-30T20:08:39Z",
          "completed_at" => "2013-07-30T19:19:05Z",
          "payment_total" => "114.95",
          "shipment_state" => "partial",
          "payment_state" => "paid",
          "email" => "spree@example.com",
          "special_instructions" => nil,
          "currency" => "USD",
          "ship_total" => "10.0",
          "tax_total" => "5.0",
          "bill_address" => {
            "id" => 5,
            "firstname" => "Brian",
            "lastname" => "Quinn",
            "address1" => "7735 Old Georgetown Rd",
            "address2" => "",
            "city" => "Bethesda",
            "zipcode" => "20814",
            "phone" => "555-123-456",
            "company" => nil,
            "alternative_phone" => nil,
            "country_id" => 49,
            "state_id" => 26,
            "state_name" => nil,
            "country" => {
              "id" => 49,
              "iso_name" => "UNITED STATES",
              "iso" => "US",
              "iso3" => "USA",
              "name" => "United States",
              "numcode" => 840
            },
            "state" => {
              "id" => 26,
              "name" => "Maryland",
              "abbr" => "MD",
              "country_id" => 49
            }
          },
          "ship_address" => {
            "id" => 6,
            "firstname" => "Brian",
            "lastname" => "Quinn",
            "address1" => "7735 Old Georgetown Rd",
            "address2" => "",
            "city" => "Bethesda",
            "zipcode" => "20814",
            "phone" => "555-123-456",
            "company" => nil,
            "alternative_phone" => nil,
            "country_id" => 49,
            "state_id" => 26,
            "state_name" => nil,
            "country" => {
              "id" => 49,
              "iso_name" => "UNITED STATES",
              "iso" => "US",
              "iso3" => "USA",
              "name" => "United States",
              "numcode" => 840
            },
            "state" => {
              "id" => 26,
              "name" => "Maryland",
              "abbr" => "MD",
              "country_id" => 49
            }
          },
          "line_items" => [
            {
              "id" => 5,
              "quantity" => 2,
              "price" => "19.99",
              "variant_id" => 8,
              "variant" => {
                "id" => 8,
                "name" => "Spree Baseball Jersey",
                "product_id" => 8,
                "sku" => "SPR-00001",
                "price" => "19.99",
                "weight" => nil,
                "height" => nil,
                "width" => nil,
                "depth" => nil,
                "is_master" => true,
                "cost_price" => "17.0",
                "permalink" => "spree-baseball-jersey",
                "options_text" => "",
                "option_values" => [

                ],
                "images" => [
                  {
                    "id" => 41,
                    "position" => 1,
                    "attachment_content_type" => "image/jpeg",
                    "attachment_file_name" => "spree_jersey.jpeg",
                    "type" => "Spree::Image",
                    "attachment_updated_at" => "2013-07-24T17:01:27Z",
                    "attachment_width" => 480,
                    "attachment_height" => 480,
                    "alt" => nil,
                    "viewable_type" => "Spree::Variant",
                    "viewable_id" => 8,
                    "attachment_url" => "/spree/products/41/product/spree_jersey.jpeg?1374685287"
                  },
                  {
                    "id" => 42,
                    "position" => 2,
                    "attachment_content_type" => "image/jpeg",
                    "attachment_file_name" => "spree_jersey_back.jpeg",
                    "type" => "Spree::Image",
                    "attachment_updated_at" => "2013-07-24T17:01:28Z",
                    "attachment_width" => 480,
                    "attachment_height" => 480,
                    "alt" => nil,
                    "viewable_type" => "Spree::Variant",
                    "viewable_id" => 8,
                    "attachment_url" => "/spree/products/42/product/spree_jersey_back.jpeg?1374685288"
                  }
                ]
              }
            },
            {
              "id" => 7,
              "quantity" => 3,
              "price" => "19.99",
              "variant_id" => 20,
              "variant" => {
                "id" => 20,
                "name" => "Ruby on Rails Baseball Jersey",
                "product_id" => 3,
                "sku" => "ROR-00004",
                "price" => "19.99",
                "weight" => nil,
                "height" => nil,
                "width" => nil,
                "depth" => nil,
                "is_master" => false,
                "cost_price" => "17.0",
                "permalink" => "ruby-on-rails-baseball-jersey",
                "options_text" => "Size: M, Color: Red",
                "option_values" => [
                  {
                    "id" => 33,
                    "name" => "Red",
                    "presentation" => "Red",
                    "option_type_name" => "tshirt-color",
                    "option_type_id" => 2
                  },
                  {
                    "id" => 16,
                    "name" => "Medium",
                    "presentation" => "M",
                    "option_type_name" => "tshirt-size",
                    "option_type_id" => 1
                  }
                ],
                "images" => [
                  {
                    "id" => 7,
                    "position" => 1,
                    "attachment_content_type" => "image/png",
                    "attachment_file_name" => "ror_baseball_jersey_red.png",
                    "type" => "Spree::Image",
                    "attachment_updated_at" => "2013-07-24T17:00:58Z",
                    "attachment_width" => 240,
                    "attachment_height" => 240,
                    "alt" => nil,
                    "viewable_type" => "Spree::Variant",
                    "viewable_id" => 20,
                    "attachment_url" => "/spree/products/7/product/ror_baseball_jersey_red.png?1374685258"
                  },
                  {
                    "id" => 8,
                    "position" => 2,
                    "attachment_content_type" => "image/png",
                    "attachment_file_name" => "ror_baseball_jersey_back_red.png",
                    "type" => "Spree::Image",
                    "attachment_updated_at" => "2013-07-24T17:00:59Z",
                    "attachment_width" => 240,
                    "attachment_height" => 240,
                    "alt" => nil,
                    "viewable_type" => "Spree::Variant",
                    "viewable_id" => 20,
                    "attachment_url" => "/spree/products/8/product/ror_baseball_jersey_back_red.png?1374685259"
                  }
                ]
              }
            }
          ],
          "payments" => [
            {
              "id" => 6,
              "amount" => "5.0",
              "state" => "completed",
              "payment_method_id" => 5,
              "payment_method" => {
                "id" => 5,
                "name" => "Check",
                "environment" => "development"
              }
            },
            {
              "id" => 5,
              "amount" => "109.95",
              "state" => "completed",
              "payment_method_id" => 1,
              "payment_method" => {
                "id" => 1,
                "name" => "Credit Card",
                "environment" => "development"
              }
            }
          ],
          "shipments" => [
            {
              "id" => 6,
              "tracking" => nil,
              "number" => "H215918586",
              "cost" => "5.0",
              "shipped_at" => "2013-07-30T20:08:38Z",
              "state" => "shipped",
              "order_id" => "R827587314",
              "stock_location_name" => "default",
              "shipping_rates" => [
                {
                  "id" => 74,
                  "cost" => "10.0",
                  "selected" => false,
                  "shipment_id" => 6,
                  "shipping_method_id" => 2
                },
                {
                  "id" => 75,
                  "cost" => "15.0",
                  "selected" => false,
                  "shipment_id" => 6,
                  "shipping_method_id" => 3
                },
                {
                  "id" => 73,
                  "cost" => "5.0",
                  "selected" => true,
                  "shipment_id" => 6,
                  "shipping_method_id" => 1
                }
              ],
              "shipping_method" => {
                "name" => "UPS Ground (USD)"
              },
              "inventory_units" => [
                {
                  "id" => 16,
                  "state" => "shipped",
                  "variant_id" => 8,
                  "order_id" => nil,
                  "shipment_id" => 6,
                  "return_authorization_id" => nil
                },
                {
                  "id" => 15,
                  "state" => "shipped",
                  "variant_id" => 20,
                  "order_id" => nil,
                  "shipment_id" => 6,
                  "return_authorization_id" => nil
                }
              ]
            },
            {
              "id" => 5,
              "tracking" => "4532535354353452",
              "number" => "H541684679",
              "cost" => "5.0",
              "shipped_at" => nil,
              "state" => "ready",
              "order_id" => "R827587314",
              "stock_location_name" => "default",
              "shipping_rates" => [
                {
                  "id" => 80,
                  "cost" => "10.0",
                  "selected" => false,
                  "shipment_id" => 5,
                  "shipping_method_id" => 2
                },
                {
                  "id" => 81,
                  "cost" => "15.0",
                  "selected" => false,
                  "shipment_id" => 5,
                  "shipping_method_id" => 3
                },
                {
                  "id" => 79,
                  "cost" => "5.0",
                  "selected" => true,
                  "shipment_id" => 5,
                  "shipping_method_id" => 1
                }
              ],
              "shipping_method" => {
                "name" => "UPS Ground (USD)"
              },
              "inventory_units" => [
                {
                  "id" => 13,
                  "state" => "on_hand",
                  "variant_id" => 20,
                  "order_id" => 5,
                  "shipment_id" => 5,
                  "return_authorization_id" => nil
                },
                {
                  "id" => 12,
                  "state" => "on_hand",
                  "variant_id" => 20,
                  "order_id" => 5,
                  "shipment_id" => 5,
                  "return_authorization_id" => nil
                },
                {
                  "id" => 10,
                  "state" => "on_hand",
                  "variant_id" => 8,
                  "order_id" => 5,
                  "shipment_id" => 5,
                  "return_authorization_id" => nil
                }
              ]
            }
          ],
          "adjustments" => [
            {
              "id" => 16,
              "amount" => "5.0",
              "label" => "Shipping",
              "mandatory" => true,
              "eligible" => true,
              "originator_type" => "Spree::ShippingMethod",
              "adjustable_type" => "Spree::Order"
            },
            {
              "id" => 20,
              "amount" => "5.0",
              "label" => "Shipping",
              "mandatory" => true,
              "eligible" => true,
              "originator_type" => "Spree::ShippingMethod",
              "adjustable_type" => "Spree::Order"
            },
            {
              "id" => 22,
              "amount" => "5.0",
              "label" => "North America 5.0",
              "mandatory" => false,
              "eligible" => true,
              "originator_type" => "Spree::TaxRate",
              "adjustable_type" => "Spree::Order"
            }
          ],
          "credit_cards" => [
            {
              "id" => 2,
              "month" => "7",
              "year" => "2013",
              "cc_type" => "visa",
              "last_digits" => "1111",
              "first_name" => "Brian",
              "last_name" => "Quinn",
              "gateway_customer_profile_id" => "BGS-414100",
              "gateway_payment_profile_id" => nil
            }
          ]
        }
      }.merge(args)
    end
  end
end
