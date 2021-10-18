
import 'selectize/dist/js/selectize.min.js'; 
import 'selectize/dist/css/selectize.scss';

const selectize = () => {
  $('.select-beast').selectize({
      // create: true, (from example on selectize page)
      sortField: 'text'
  });

};

export { selectize }; 