// Folding solutions.
// Code modified from the answer for the question on stackoverflow
// https://stackoverflow.com/questions/45360998/code-folding-in-bookdown

window.initializeSolutionFolding = function(show) {

  // handlers for show-all and hide all
  $("#rmd-show-all-solution").click(function() {
    $('div.solution-collapse').each(function() {
      $(this).collapse('show');
    });
  });
  $("#rmd-hide-all-solution").click(function() {
    $('div.solution-collapse').each(function() {
      $(this).collapse('hide');
    });
  });

  // index for unique solution element ids
  var currentIndex = 1;

  // select all solution blocks
  var rSolutionBlocks = $('div.solution');
  rSolutionBlocks.each(function() {

    // create a collapsable div to wrap the solution in
    var div = $('<div class="collapse solution-collapse"></div>');
    if (show)
      div.addClass('in');
    var id = 'solution-643E0F36' + currentIndex++;
    div.attr('id', id);
    $(this).before(div);
    $(this).detach().appendTo(div);

    // add a show solution button right above
    var showSolutionText = $('<span>' + (show ? 'Hide' : 'Solution') + '</span>');
    var showSolutionButton = $('<button type="button" class="btn btn-default btn-xs solution-folding-btn pull-right"></button>');
    showSolutionButton.append(showSolutionText);
    showSolutionButton
        .attr('data-toggle', 'collapse')
        .attr('data-target', '#' + id)
        .attr('aria-expanded', show)
        .attr('aria-controls', id);

    var buttonRow = $('<div class="solution-button-row"></div>');
    var buttonCol = $('<div class="col-md-12"></div>');

    buttonCol.append(showSolutionButton);
    buttonRow.append(buttonCol);

    div.before(buttonRow);

    // update state of button on show/hide
    // div.on('hidden.bs.collapse', function () {
    //   showSolutionText.text('Show');
    // });
    // div.on('show.bs.collapse', function () {
    //   showSolutionText.text('Hide');
    // });
  });

}
