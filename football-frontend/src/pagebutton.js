import React from 'react'

class PageButton extends React.Component {
    render() {
        return(
            <div>
            <button onClick={this.props.pageBack}>Previous Page</button>
            <button onClick={this.props.pageforward}>Next Page</button>
            </div>
        )
    }
}

export default PageButton