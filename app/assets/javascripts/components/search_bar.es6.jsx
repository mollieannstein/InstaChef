class SearchBar extends React.Component {
  render () {
    return (
      <div className="search-bar">
      <form action='/recipes/search' acceptCharset='UTF-8' method='get'>
        <input name='utf-8' type='hidden' value='√' />
        <button name='button' type='submit'><span className='glyphicon glyphicon-search'></span></button>
        <input
          value={this.props.name}
          onChange={(event) => {this.props.onSearchNameChange(event.target.value)}}
          placeholder='Find a recipe...'
          autoComplete='off'
          type='search'
          name='search[name]'
          id='search_name' />
      </form>
      </div>
    );
  }
}

