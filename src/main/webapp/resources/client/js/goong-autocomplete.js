// src/main/webapp/resources/client/js/goong-autocomplete.js


$(document).ready(function () {
  const GOONG_API_KEY = 'EAddPu1fx9SFE8rAE7Ogdp1rheIPEfrhiAB65nif';
  let debounceTimer;

  $('.goong-address-input').each(function () {
    const $inputField = $(this);
    const $suggestionsContainer = $inputField.next(
      '.goong-address-suggestions'
    );

    $inputField.on('input', function () {
      const query = $(this).val();

      clearTimeout(debounceTimer);

      if (query.length < 3) {
        $suggestionsContainer.removeClass('show').empty();
        return;
      }

      debounceTimer = setTimeout(() => {
        const apiUrl = `https://rsapi.goong.io/Place/AutoComplete?api_key=${GOONG_API_KEY}&input=${encodeURIComponent(
          query
        )}&limit=5`;

        fetch(apiUrl)
          .then((response) => {
            if (!response.ok) {
              throw new Error(
                'Network response was not ok ' + response.statusText
              );
            }
            return response.json();
          })
          .then((data) => {
            $suggestionsContainer.empty();
            if (data.predictions && data.predictions.length > 0) {
              data.predictions.forEach((prediction) => {
                const $suggestionItem = $(
                  '<button type="button" class="dropdown-item"></button>'
                )
                  .text(prediction.description)
                  .on('click', function () {
                    $inputField.val(prediction.description);
                    $suggestionsContainer.removeClass('show').empty();
                    $inputField.trigger('change');
                  });
                $suggestionsContainer.append($suggestionItem);
              });
              $suggestionsContainer.addClass('show');
            } else {
              $suggestionsContainer.removeClass('show');
            }
          })
          .catch((error) => {
            console.error('Goong API Error:', error);
            $suggestionsContainer.removeClass('show').empty();
          });
      }, 500);
    });

    $(document).on('click', function (e) {
      if (
        !$inputField.is(e.target) &&
        $inputField.has(e.target).length === 0 &&
        !$suggestionsContainer.is(e.target) &&
        $suggestionsContainer.has(e.target).length === 0
      ) {
        $suggestionsContainer.removeClass('show').empty();
      }
    });
  });
});
