import React from 'react'

class Fixture extends React.Component {

    dateRenderer = () => {
        if (this.props.game) {
            let date_array = this.props.game.date.split(/[T-]/)
            return `${date_array[1]}-${date_array[2]}`
        }
    }

    clickHandler = () => {
        if (!this.props.home) {
            this.props.gameStatRender(this.props.game.home_team, this.props.game.away_team)
        }
    }

    render() {
        return(
            <tr onClick={this.clickHandler} className="Fixture"><td>{this.dateRenderer()}</td><td>{this.props.game.home_team}</td><td>vs.</td><td>{this.props.game.away_team}</td></tr>
        )
    }
}

export default Fixture