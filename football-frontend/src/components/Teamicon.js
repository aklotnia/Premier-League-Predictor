import React from 'react'

class Teamicon extends React.Component {
    render() {
        return(
            <img onClick={() => {this.props.teamChooser(this.props.team.name)}} className="ClubCrest" src={this.props.team.logo} alt={this.props.team.name} />
        )
    }
}

export default Teamicon