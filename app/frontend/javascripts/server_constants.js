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
    email_row_helpers: "/helpers/email_row",
    donation_row_maintainers: "/maintainers/donation_row",
    send_to_analysis_product_and_service_weeks: "/product_and_service_weeks/send_to_analysis",
    send_maintainers_product_and_service_weeks: "/product_and_service_weeks/send_maintainers",
    create_and_new_donations: "/donations/create_and_new",

    assets: {
      edit: "/assets/edit-948a7de1e9b5b9831a539a276d13172ebcc261325a7936481e240174cd00d40a.png",
      delete: "/assets/delete-3a0379bf402ba2c782f7391618c6af3ec238cd0cbf83a73d95fb64779b2b9e11.png"
    }
  },

  system_settings: {
    receipt_title: "Donation Receipt for #maintainer - #competence"
  },
  admin_email: "ftquixada@gmail.com",

  week_totals_number: 6,
  week_final_number: 7,
  number_of_services: 6,
  number_of_products: 8,
  number_of_weeks: 7,
  products_array: ["mesh", "cream", "protector", "silicon", "mask", "foam", "skin_expander", "cervical_collar"],
  services_array: ["psychology", "physiotherapy", "plastic_surgery", "mesh", "gynecology", "occupational_therapy"],
}

export default Constants
