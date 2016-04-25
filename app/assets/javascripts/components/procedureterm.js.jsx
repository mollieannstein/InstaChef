var ProcedureTerm = React.createClass ({

  handleClick: function(event) {
    var details = $(event.target)
    details.find('.instructions').slideToggle();
  },

  render: function() {
    return (
      <div onClick={this.handleClick} className="col-sm-2 btn-default panel-heading">
        {this.props.procedure.term} <div className="button panel-body instructions">{this.props.procedure.instructions}</div>
      </div>
    );
  }
});