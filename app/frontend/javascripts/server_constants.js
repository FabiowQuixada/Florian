// This file was generated through erb templating. Any changes you do directly
// in this file will be overriden when the "build_client_data:all" rake task is run;

const Constants = {
  payment_freq: {
    undefined: "undefined",
    diary: "diary",
    weekly: "weekly",
    monthly: "monthly",
    bimonthly: "bimonthly",
    semiannually: "semiannually",
    annually: "annually",
    other: "other",
  },

  paths: {
    send_to_analysis_product_and_service_weeks: "/product_and_service_weeks/send_to_analysis",
    send_maintainers_product_and_service_weeks: "/product_and_service_weeks/send_maintainers",
    create_and_new_donations: "/donations/create_and_new",

    assets: {
      edit: "/assets/edit-948a7de1e9b5b9831a539a276d13172ebcc261325a7936481e240174cd00d40a.png",
      delete: "/assets/delete-3a0379bf402ba2c782f7391618c6af3ec238cd0cbf83a73d95fb64779b2b9e11.png",
      activate: "/assets/activate-1ba06c9e55681638539c7f621edb2d27abddff75fee30604edf3b0bc8629eb7c.png",
      deactivate: "/assets/deactivate-8b6116799d6aa7b16f68da5b33d97cb50eea6d55ced20194b220829471d6da58.png",
    }
  },

  system_settings: {
    receipt_title: "Donation Receipt for #maintainer - #competence"
  },

  showcase_env: {
    user: "guest",
    user_numbers: [1909, 1224, 2043, 2049, 1166, 1890, 1811, 2462, 2321, 1725, 2658, 1538, 1229, 2775, 2685, 2265, 1887, 2808, 1874, 2071],
    password: "guest_pass"
  },

  admin_email: "ftquixada@gmail.com",

  week_totals_number: 6,
  week_final_number: 7,
  number_of_services: 6,
  number_of_products: 8,
  number_of_bill_types: 3,
  number_of_weeks: 7,
  products_array: ["mesh", "cream", "protector", "silicon", "mask", "foam", "skin_expander", "cervical_collar"],
  services_array: ["psychology", "physiotherapy", "plastic_surgery", "mesh", "gynecology", "occupational_therapy"],
}

export default Constants
